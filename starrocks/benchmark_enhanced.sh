#!/bin/bash

# Enhanced ClickBench with JOIN queries for StarRocks

set -e

VERSION=3.4.2-ubuntu-$(dpkg --print-architecture)

echo "========================================="
echo "Enhanced ClickBench for StarRocks"
echo "Includes: 43 original queries + 17 JOIN queries"
echo "========================================="

# Install StarRocks
wget --continue --progress=dot:giga https://releases.starrocks.io/starrocks/StarRocks-$VERSION.tar.gz -O StarRocks-$VERSION.tar.gz
tar zxvf StarRocks-${VERSION}.tar.gz

cd StarRocks-${VERSION}/

# Install dependencies
sudo apt-get update -y
sudo apt-get install -y openjdk-17-jre mariadb-client
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-$(dpkg --print-architecture)
export PATH=$JAVA_HOME/bin:$PATH

# Create directory for FE and BE
IPADDR=`hostname -i`
export STARROCKS_HOME=`pwd`
mkdir -p meta storage

# Start Frontend
echo "meta_dir = ${STARROCKS_HOME}/meta " >> fe/conf/fe.conf
fe/bin/start_fe.sh --daemon

# Start Backend
echo "storage_root_path = ${STARROCKS_HOME}/storage" >> be/conf/be.conf
be/bin/start_be.sh --daemon

# Setup cluster
sleep 30
mysql -h 127.0.0.1 -P9030 -uroot -e "ALTER SYSTEM ADD BACKEND '${IPADDR}:9050' "
sleep 30

cd ../

# Prepare Data
sudo apt-get install -y pigz
wget --continue --progress=dot:giga 'https://datasets.clickhouse.com/hits_compatible/hits.tsv.gz'
pigz -d -f hits.tsv.gz

echo "========================================="
echo "Creating database and tables..."
echo "========================================="

# Create database
mysql -h 127.0.0.1 -P9030 -uroot -e "CREATE DATABASE hits"

# Create main hits table
mysql -h 127.0.0.1 -P9030 -uroot hits < create.sql

# Create enhanced tables for JOIN testing
mysql -h 127.0.0.1 -P9030 -uroot hits < create_enhanced.sql

echo "========================================="
echo "Loading main dataset..."
echo "========================================="

# Load main hits data
START=$(date +%s)
echo "Start to load main hits data..."
curl --location-trusted \
    -u root: \
    -T "hits.tsv" \
    -H "label:hits_tsv_${START}" \
    -H "columns: WatchID,JavaEnable,Title,GoodEvent,EventTime,EventDate,CounterID,ClientIP,RegionID,UserID,CounterClass,OS,UserAgent,URL,Referer,IsRefresh,RefererCategoryID,RefererRegionID,URLCategoryID,URLRegionID,ResolutionWidth,ResolutionHeight,ResolutionDepth,FlashMajor,FlashMinor,FlashMinor2,NetMajor,NetMinor,UserAgentMajor,UserAgentMinor,CookieEnable,JavascriptEnable,IsMobile,MobilePhone,MobilePhoneModel,Params,IPNetworkID,TraficSourceID,SearchEngineID,SearchPhrase,AdvEngineID,IsArtifical,WindowClientWidth,WindowClientHeight,ClientTimeZone,ClientEventTime,SilverlightVersion1,SilverlightVersion2,SilverlightVersion3,SilverlightVersion4,PageCharset,CodeVersion,IsLink,IsDownload,IsNotBounce,FUniqID,OriginalURL,HID,IsOldCounter,IsEvent,IsParameter,DontCountHits,WithHash,HitColor,LocalEventTime,Age,Sex,Income,Interests,Robotness,RemoteIP,WindowName,OpenerName,HistoryLength,BrowserLanguage,BrowserCountry,SocialNetwork,SocialAction,HTTPError,SendTiming,DNSTiming,ConnectTiming,ResponseStartTiming,ResponseEndTiming,FetchTiming,SocialSourceNetworkID,SocialSourcePage,ParamPrice,ParamOrderID,ParamCurrency,ParamCurrencyID,OpenstatServiceName,OpenstatCampaignID,OpenstatAdID,OpenstatSourceID,UTMSource,UTMMedium,UTMCampaign,UTMContent,UTMTerm,FromTag,HasGCLID,RefererHash,URLHash,CLID" \
    http://localhost:8030/api/hits/hits/_stream_load

END=$(date +%s)
LOADTIME=$(echo "$END - $START" | bc)
echo "Main data load time: $LOADTIME seconds"

echo "========================================="
echo "Loading dimension tables..."
echo "========================================="

# Load sample dimension data
mysql -h 127.0.0.1 -P9030 -uroot hits < load_sample_data.sql

echo "Dimension data loaded successfully."

# Check data sizes
echo -n "Total data size: "
du -bcs StarRocks-${VERSION}/storage/ | grep total

# Verify row counts
echo "Row count verification:"
mysql -h 127.0.0.1 -P9030 -uroot hits -e "SELECT 'hits' as table_name, count(*) as row_count FROM hits
UNION ALL SELECT 'users', count(*) FROM users  
UNION ALL SELECT 'regions', count(*) FROM regions
UNION ALL SELECT 'search_engines', count(*) FROM search_engines
UNION ALL SELECT 'adv_engines', count(*) FROM adv_engines"

echo "========================================="
echo "Running Standard ClickBench (43 queries)..."
echo "========================================="

./run.sh 2>&1 | tee -a log_standard.txt

echo "========================================="
echo "Running Enhanced JOIN Queries (17 queries)..."
echo "========================================="

./run_enhanced.sh 2>&1 | tee -a log_enhanced.txt

echo "========================================="
echo "Processing Results..."
echo "========================================="

echo "=== STANDARD CLICKBENCH RESULTS ==="
cat log_standard.txt |
  grep -P 'rows? in set|Empty set|^ERROR' |
  sed -r -e 's/^ERROR.*$/null/; s/^.*?\((([0-9.]+) min )?([0-9.]+) sec\).*?$/\2 \3/' |
  awk '{ if ($2 != "") { print $1 * 60 + $2 } else { print $1 } }' |
  awk '{ if (i % 3 == 0) { printf "[" }; printf $1; if (i % 3 != 2) { printf "," } else { print "]," }; ++i; }'

echo ""
echo "=== ENHANCED JOIN QUERIES RESULTS ==="
cat log_enhanced.txt |
  grep -P 'rows? in set|Empty set|^ERROR' |
  sed -r -e 's/^ERROR.*$/null/; s/^.*?\((([0-9.]+) min )?([0-9.]+) sec\).*?$/\2 \3/' |
  awk '{ if ($2 != "") { print $1 * 60 + $2 } else { print $1 } }' |
  awk '{ if (i % 3 == 0) { printf "[" }; printf $1; if (i % 3 != 2) { printf "," } else { print "]," }; ++i; }'

echo ""
echo "========================================="
echo "Benchmark completed!"
echo "Standard ClickBench: 43 queries"
echo "Enhanced JOIN tests: 17 queries"
echo "Total: 60 queries tested"
echo "========================================"

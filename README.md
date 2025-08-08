# ClickBench Test Suite for StarRocks, Firebolt, and SingleStore

This repository contains complete test implementations for running the [ClickBench](https://github.com/ClickHouse/ClickBench) analytical database benchmark on three modern databases:

- **StarRocks** - Open-source MPP analytical database
- **Firebolt** - Cloud-native data warehouse
- **SingleStore** - Distributed HTAP SQL database

## 🎯 What is ClickBench?

ClickBench is a standardized benchmark for analytical databases that:
- Uses a realistic web analytics dataset (99,997,497 records)
- Tests 43 carefully designed queries covering various analytical workloads
- Measures both cold and hot query performance
- Provides reproducible results across different systems

## 📁 Repository Structure

```
├── starrocks/          # StarRocks implementation
│   ├── benchmark.sh    # Complete automated setup and test
│   ├── create.sql      # Table schema definition
│   ├── queries.sql     # All 43 ClickBench queries
│   ├── run.sh          # Query execution script
│   └── README.md       # Database-specific notes
├── firebolt/           # Firebolt implementation
│   ├── benchmark.sh    # Docker-based Firebolt Core setup
│   ├── create.sql      # External + main table definitions
│   ├── queries.sql     # All 43 ClickBench queries
│   └── run.sh          # HTTP API query execution
└── singlestore/        # SingleStore implementation
    ├── benchmark.sh    # Cluster-in-a-box setup
    ├── create.sql      # Columnstore table definition
    ├── queries.sql     # All 43 ClickBench queries
    ├── run.sh          # Query execution with compilation handling
    └── README.md       # Local vs cloud setup options
```

## 🚀 Quick Start

### Prerequisites

- Ubuntu 22.04+ (recommended)
- 16GB+ RAM, 100GB+ storage
- Docker installed
- Administrative privileges

### Running Tests

Each database can be tested independently:

```bash
# StarRocks - Standard ClickBench
cd starrocks && ./benchmark.sh

# StarRocks - Enhanced with JOINs (60 total queries)
cd starrocks && ./benchmark_enhanced.sh

# Firebolt
cd firebolt && ./benchmark.sh

# SingleStore (requires license key)
export LICENSE_KEY="your_license_key"
export ROOT_PASSWORD="your_password"
cd singlestore && ./benchmark.sh
```

## 📊 What Each Test Does

### 1. Environment Setup
- Installs database software
- Downloads ClickBench dataset (~10GB)
- Configures optimal settings

### 2. Data Loading
- Creates appropriate table schema
- Loads 99,997,497 records
- Measures load time and storage size

### 3. Query Execution
- Runs all 43 ClickBench queries
- 3 runs per query (1 cold + 2 hot)
- Clears system caches between cold runs

### 4. Results Collection
- Outputs timing in standard format
- Compatible with ClickBench analysis tools
- Measures both performance and resource usage

## 🔍 Comprehensive Query Testing

### Standard ClickBench (43 Queries)
The original ClickBench queries test various analytical scenarios:

1. **Basic Aggregations** (1-7): COUNT, SUM, AVG, MIN, MAX
2. **GROUP BY Operations** (8-18): Various grouping scenarios
3. **String Processing** (19-29): LIKE patterns, regex, text functions
4. **Complex Analytics** (30-43): Wide aggregations, time series, pagination

### Enhanced JOIN Queries (17 Additional Queries)
Extended test suite includes multi-table operations:

1. **Basic JOINs** (44-47): INNER/LEFT JOIN with dimension tables
2. **Complex JOINs** (48-52): Multiple tables, window functions, subqueries
3. **Analytics JOINs** (53-57): Cross-dimensional analysis, user journeys
4. **Advanced JOINs** (58-60): Time zones, market analysis, ranking

Examples:
```sql
-- Query 1: Simple count
SELECT COUNT(*) FROM hits;

-- Query 9: Top regions by unique users
SELECT RegionID, COUNT(DISTINCT UserID) AS u 
FROM hits GROUP BY RegionID ORDER BY u DESC LIMIT 10;

-- Query 44: JOIN with search engines (Enhanced)
SELECT se.SearchEngineName, COUNT(*) AS hits_count
FROM hits h 
INNER JOIN search_engines se ON h.SearchEngineID = se.SearchEngineID
WHERE h.SearchPhrase <> ''
GROUP BY se.SearchEngineName ORDER BY hits_count DESC LIMIT 10;

-- Query 60: Complex multi-table analysis (Enhanced)
SELECT r.Country, u.UserSegment, COUNT(*) AS total_hits,
       ROW_NUMBER() OVER (PARTITION BY r.Country ORDER BY COUNT(*) DESC) AS rank
FROM hits h
INNER JOIN users u ON h.UserID = u.UserID
INNER JOIN regions r ON h.RegionID = r.RegionID
GROUP BY r.Country, u.UserSegment ORDER BY total_hits DESC LIMIT 50;
```

## 📈 Expected Results

Each benchmark outputs:
```
Load time: 1234
Data size: 1234567890
[0.123, 0.098, 0.089],  # Query 1: [cold, hot1, hot2]
[1.234, 0.987, 0.876],  # Query 2: [cold, hot1, hot2]
...
[5.678, 4.321, 3.210],  # Query 43: [cold, hot1, hot2]
```

## 🗃️ Database-Specific Features

### StarRocks
- MPP architecture with FE/BE separation
- Stream loading via HTTP API
- MySQL protocol compatibility
- Vectorized execution engine

### Firebolt
- Cloud-native with automatic optimization
- Parquet-based data loading
- HTTP API with JSON responses
- Configurable caching strategies

### SingleStore
- HTAP with row/column stores
- MySQL wire protocol
- Async query compilation
- Distributed sharding

## 🔧 Customization

### Modifying Queries
Edit `queries.sql` in each directory to:
- Add custom queries
- Modify existing queries
- Test database-specific features

### Configuration Changes
Edit `create.sql` to adjust:
- Table schema (data types, indices)
- Storage settings
- Partitioning strategies

### Hardware Optimization
Modify `benchmark.sh` for:
- Memory allocation
- CPU core usage
- Storage configuration

## 🐛 Troubleshooting

### Common Issues

**StarRocks:**
- Port conflicts (8030, 9030, 9050)
- Java version requirements (JDK 17+)
- Memory allocation for large datasets

**Firebolt:**
- Docker memory limits (8GB+ required)
- Container startup timeouts
- Network connectivity issues

**SingleStore:**
- License key validation
- Memory requirements (16GB+ recommended)
- Container initialization time

### Performance Tips

1. **System Optimization:**
   ```bash
   # Disable swap
   sudo swapoff -a
   
   # Tune kernel parameters
   echo 'vm.swappiness=1' | sudo tee -a /etc/sysctl.conf
   ```

2. **Storage:**
   - Use SSD storage for better I/O
   - Ensure sufficient free space (3x dataset size)

3. **Memory:**
   - Close unnecessary applications
   - Monitor memory usage during tests

## 📝 Contributing

1. Fork this repository
2. Add new database implementations
3. Follow the existing structure:
   - `benchmark.sh` - Complete setup script
   - `create.sql` - Table definition
   - `queries.sql` - All 43 queries
   - `run.sh` - Query execution
   - `README.md` - Setup notes

4. Submit pull request with results

## 📚 References

- [ClickBench Official Repository](https://github.com/ClickHouse/ClickBench)
- [ClickBench Results Website](https://benchmark.clickhouse.com/)
- [StarRocks Documentation](https://docs.starrocks.io/)
- [Firebolt Documentation](https://docs.firebolt.io/)
- [SingleStore Documentation](https://docs.singlestore.com/)

## 📄 License

This project follows the same license as the original ClickBench repository.

## 🤝 Acknowledgments

- ClickHouse team for creating the ClickBench benchmark
- Database vendors for providing accessible testing platforms
- Community contributors for feedback and improvements
# clickbench-test-suite

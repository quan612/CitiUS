using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SpecFlowIntegration.FileProcessingTest.Repository
{
    public class BaseRepository
    {
        private string _connectionString =
            "Server=Donald\\Release;Database=eCollect_v1_1;UID=sa;PWD=i$qs1234;MultipleActiveResultSets=True;";
        protected BaseRepository()
        {
            ConnectionString = _connectionString;
        }

        /// <summary>
        /// Initializes a new instance of the BaseRepository class.
        /// </summary>
        /// <param name="connectionString">The database connection string to use.</param>
        protected BaseRepository(string connectionString)
        {
            ConnectionString = connectionString;
        }

        /// <summary>
        /// Gets the connection string.
        /// </summary>
        public static string ConnectionString { get; private set; }
    }
}

public DataTable Select(string storedProcedureorCommandText, bool isStoredProcedure = true)
{
    DataTable dataTable = new DataTable();
    using (SqlConnection connection = new SqlConnection("ConnectionString"))
    {
        using (SqlCommand command = new SqlCommand())
        {
            command.Connection = connection;
            command.CommandType = CommandType.StoredProcedure;
            if (!isStoredProcedure)
            {
            command.CommandType = CommandType.Text;
            }
            command.CommandText = storedProcedureorCommandText;
            connection.Open();

            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);

            return dataTable;
        }
    }
}

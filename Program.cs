using System;
using System.Data;
using System.Data.SqlClient;

class Program
{
	static void Main()
	{
		string connectionString = @"Server=DESKTOP-9AGBIEE\SQLEXPRESS;Database=GestionCobrosDB;Integrated Security=True;"; ;

		using (SqlConnection connection = new SqlConnection(connectionString))
		{
			connection.Open();
			SqlCommand command = new SqlCommand("SP_asignarSaldosAGestores", connection);
			command.CommandType = CommandType.StoredProcedure;

			using (SqlDataReader reader = command.ExecuteReader())
			{
				while (reader.Read())
				{
					Console.WriteLine($"GestorId: {reader["GestorId"]}, TotalSaldos: {reader["TotalSaldos"]}");
				}
			}
		}
	}
}

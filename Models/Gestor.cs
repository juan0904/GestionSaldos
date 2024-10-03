using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionSaldos.Models
{
	public class Gestor
	{
		public int GestorId { get; set; }
		public decimal TotalSaldos { get; set; }

		public Gestor(int id)
		{
			GestorId = id;
			TotalSaldos = 0;
		}
	}
}

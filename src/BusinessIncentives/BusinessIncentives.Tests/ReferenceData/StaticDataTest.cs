using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using BusinessIncentives.Common.ReferenceData;

namespace BusinessIncentives.Tests.Controllers
{
	[TestClass]
	public class StaticDataTest
	{
		[TestMethod]
		public void IgnorableExpressionList_IsComplete_And_HasNoLeadingOrTrailingSpaces()
		{
			var underTest = StaticData.IgnorableWordsExpressions;

			// Assert
			Assert.AreEqual(underTest.Count, 231);
			Assert.IsTrue(underTest.All(e => !e.StartsWith(" ")));
			Assert.IsTrue(underTest.All(e => !e.EndsWith(" ")));
		}
	}
}

using System.Web;

namespace BusinessIncentives.Common.Extensions
{
	public static class StringExtensions
	{
		public static string LimitLengthTo(this string source, int maxLength, bool addDots)
		{
			if(source == null)
			{
				return string.Empty;
			}

			if (source.Length <= maxLength)
			{
				return source;
			}

			return source.Substring(0, maxLength) + (addDots ? "...": string.Empty);
		}

		public static string Cleanup(this string source)
		{
			if(source == null)
			{
				return string.Empty;
			}
			return HttpUtility.HtmlDecode(source).Replace(@"�", "'");
		}
	}
}

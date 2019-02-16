using System.Linq;
using System.Collections.Generic;
using BusinessIncentives.Common.ReferenceData;

namespace BusinessIncentives.Common
{
	public class KeywordCurator
	{
		public List<string> GetCuratedKeywords(List<string> keywords)
		{
			if (keywords == null) return new List<string>();
			// Filter out ignorable expression
			var curatedKeywords = keywords?.Where(kw => !StaticData.IgnorableWordsExpressions.Contains(kw)).ToList();

			// Remove punctuation
			var keywordsWithoutPunctuation = curatedKeywords?.Select(ckw => new string(ckw.Where(c => !char.IsPunctuation(c)).ToArray())).ToList();			

			return keywordsWithoutPunctuation;
		}
	}
}

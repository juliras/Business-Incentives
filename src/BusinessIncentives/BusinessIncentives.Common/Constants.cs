using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessIncentives.Common
{
	public partial class Constants
	{
		private static string ignorableExpressions =
			//Conjunctions
			"after,although,as,as if,as long as,as much as,as soon as,as though,because,before,by the time,even if,even though,if,in order that,in case,lest,once,only if,provided that,since,so that,than,that,though,till,unless,until,when,whenever,where,wherever,while," +
			//Prepositions
			"above,across,after,at,around,before,behind,below,beside,between,by,down,during,for,from,in,inside,onto,of,off,on,out,through,to,under,up,with,aboard,about,above,across,after,against,ahead of,along,amid,amidst,among,around,as,as far as,as of,aside from,at,athwart,atop,barring,because of,before,behind,below,beneath,beside,besides,between,beyond,but,by,by means of,circa,concerning,despite,down,during,except,except for,excluding,far from,following,for,from,in,in accordance with,in addition to,in case of,in front of,in lieu of,in place of,inspite of,including,inside,instead of,into,like,minus,near,next to,not withstanding,of,off,on,on account of,on behalf of,on top of,onto,opposite,out,out of,outside,over,past,plus,prior to,regarding,regardless of,save,since,than,through,till,to,toward,towards,under,underneath,unlike,until,up,upon,versus,via,with,with regard to,within,without," +
			//Pronouns
			"all,another,any,anybody,anyone,anything,both,each,either,everybody,everyone,everything,few,he,her,hers,herself,him,himself,his,I,it,its,itself,many,me mine,more,most,much,my,myself,neither,no one,nobody,none,nothing,one,other,others,our,ours,ourselves,several,she,some,somebody,someone,something,that,their,theirs,them,themselves,these,they,this,those,us,we,what,whatever,which,whichever,who,whoever,whom,whomever,whose,you,your,yours,yourself,yourselves";

		public static List<string> IgnorableWordsExpressions = ignorableExpressions.Split(',').ToList();
	}
}

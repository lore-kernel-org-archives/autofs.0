From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RE: autofs scalability
Date: Thu, 04 Dec 2003 12:04:55 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FCF9367.8040804@zytor.com>
References: <20031203194323.GB10772@sun.com>
	<Pine.LNX.4.33.0312040935420.7055-100000@wombat.indigo.net.au>
	<20031204191203.GA17865@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20031204191203.GA17865@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: thockin@sun.com
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Tim Hockin wrote:
> On Thu, Dec 04, 2003 at 09:37:44AM +0800, Ian Kent wrote:
> 
>>>removed the 256 limit, but has made it so that it CAN BE removed.  We hav a
>>>prelim patch for that, which I wan tot rework, some, maybe.
>>>
>>
>>Are you refering to the sysctl recommendation.
>>
>>I would like to do it but haven't had time.
>>
>>I'll let you know if I get to start work on it.
> 
> 
> Ditto. It's simple, but it just hasn't been high enough priority.
> 

It really would be better if it was dynamic.  Any fixed limit (other
than 2^20 minors) is really  a hack.

	-hpa

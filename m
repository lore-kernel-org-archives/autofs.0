From: Ian Kent <raven@themaw.net>
Subject: Re: Slow startup
Date: Tue, 29 Apr 2008 09:04:11 +0800
Message-ID: <1209431051.3089.3.camel@raven.themaw.net>
References: <07A371D457B501478C1DB3C3DE8372D7017C2666@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D7017C2666@GSBHEX2V.gsb.uchicago.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Young, Darren" <Darren.Young@chicagogsb.edu>
Cc: autofs@linux.kernel.org


On Mon, 2008-04-28 at 16:26 -0500, Young, Darren wrote:
> Sorry for another question, but is there any way to *not* have autofs
> read every entry on startup?

Direct maps and indirect maps that use the browse option have to be read
at startup.

If you have a large indirect map you need to not use the browse option.

> 
> I set the following for the dn I'm using for the search because it timed
> out having to read 11,000+ entries:
> 
> nsLookThroughLimit: -1
> nsSizeLimit: -1
> nsTimeLimit: -1
> nsIdleTimeout: -1
> 
> But it still takes a couple minutes to read all of them in.
> 
> Darren Young
> Systems & Security Architect
> Computing Services
> Chicago GSB
> 5807 South Woodlawn Avenue
> Chicago, IL 60637
> 
> Voice 773.702.0331 | Fax 773.702.0233
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

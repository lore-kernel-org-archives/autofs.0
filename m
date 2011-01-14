From: Michael Orlov <orlovm@cs.bgu.ac.il>
Subject: Re: autofs 5.0.4 and 5.0.5 do not remove ghost entries
 upon SIGHUP
Date: Fri, 14 Jan 2011 09:23:16 +0200
Message-ID: <20110114092316.1b0458c8@cs.bgu.ac.il>
References: <20110111183424.7f0f7ad4@cs.bgu.ac.il>
	<1294905042.2757.42.camel@perseus>
	<1294910202.2757.46.camel@perseus>
	<20110113163643.12dcadff@cs.bgu.ac.il>
	<1294973765.2794.2.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1294973765.2794.2.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> > Thanks! Will you be adding the patch to
> > http://kernel.org/pub/linux/daemons/autofs/v5/ ?
> 
> Not until I get feedback as to whether it fixes the issue and a little
> think time on my part.

I just tested on Gentoo's net-fs/autofs-5.0.5 +
fix-prune-cache-valid-check - works very well, both with the simple test
that I described previously, and with a full-blown udev-based
solution.

Best regards,
Michael

From: Ian Kent <raven@themaw.net>
Subject: Re: Re[4]: autofs reload
Date: Sat, 27 Mar 2004 09:37:00 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403270930210.28173@wombat.indigo.net.au>
References: <16484.25454.659035.551208@segfault.boston.redhat.com>
 <E1B6v3m-0000cJ-00.ia6432-inbox-ru@f25.mail.ru>
 <16484.27293.279258.40887@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16484.27293.279258.40887@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, 26 Mar 2004, Jeff Moyer wrote:

> 
> It may even be beneficial to change autofs reload to send a HUP to all
> automount daemons.  Ian, what do you think?

Oops. My bad. Implemented HUP signal for cached maps but forgot all about 
init script. I'll put together a patch for that and post it. I'm working 
all day today (Saturday) so it won't be till tomorrow.

I see you added that prevent over mount patch to the rpm as well. I like 
that one to I'm going to add it also. I'm guessing that's OK with you 
Jeff.

I'm thinking there will be a 4.1.2 bug fix release soon.

Ian

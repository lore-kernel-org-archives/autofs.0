From: Ian Kent <raven@themaw.net>
Subject: Re: Seeing some 5.0.1 stop expiring mounts
Date: Wed, 18 Jul 2007 14:42:30 +0800
Message-ID: <1184740950.4178.45.camel@raven.themaw.net>
References: <20070717195431.GA14624@cornholio.qualcomm.com>
	<20070717200433.GB14624@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070717200433.GB14624@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-07-17 at 13:04 -0700, Mike Marion wrote:
> On Tue, Jul 17, 2007 at 12:54:31PM -0700, Mike Marion wrote:
> 
> > Wondering if anyone else has seen and/or has any idea what might be the
> > cause.
> 
> Hmm.. might've found the cause at least.. common thread appears to be
> OOM situation hit on hosts in this state.  Yes, our users do this a
> LOT.. it's a big pain, we're trying to find a balance between enforcing
> limits without killing batch jobs incorrectly.
> 
> Luckily autofs5 seems to be the first autofs IME that you can kill -9
> then start a new one and have it take over the mounts properly.

Yep, it's seems to work well so far.

If you configure with --enable-ignore-busy (and for good measure
--disable-mount-locking) then you should be able to achieve the same
result with "service autofs restart", no kill needed at all.

Ian

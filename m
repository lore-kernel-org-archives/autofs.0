From: raven@themaw.net
Subject: Re: umount() and NFS races in 2.4.26
Date: Sun, 11 Jul 2004 18:16:05 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407111812460.1900@donald.themaw.net>
References: <20040708180709.GA7704@timesink.dyndns.org>
	<20040710181912.GA800@timesink.dyndns.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040710181912.GA800@timesink.dyndns.org>
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
To: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 10 Jul 2004, Thomas Moestl wrote:

> > Never the less I'm sure there is a race in waitq.c of autofs4 in 
> > 2.4 that seems to cause this problem. This is one of the things 
> > addressed by my patch.
> 
> The system in question still uses autofs3. While I believe that the
> waitq race is also present there (it could probably cause directory
> lookups to hang, if I understand it correctly), I do not think that
> any autofs3 code could cause exactly those symptoms that I have
> observed. For that, it would have to obtain dentries of the file
> systems that it has mounted, but the old code never does that.

I don't think autofs v3 has this race. It uses the BKL everywhere to 
serialise execution. Never the less people seem to see the "busy inode" 
messages sometimes.

Ian

From: Ian Kent <raven@themaw.net>
Subject: Re: Automount/NFS issues causing executables to appear corrupted
Date: Tue, 20 Apr 2004 09:27:04 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404200916221.12229@wombat.indigo.net.au>
References: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
 <40846DB7.4090102@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40846DB7.4090102@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org, ab@californiadigital.com, Venkata Ravella <Venkata.Ravella@synopsys.com>, linux-kernel@vger.kernel.org, Ramki.Balasubramanium@synopsys.com

On Mon, 19 Apr 2004, H. Peter Anvin wrote:

> Venkata Ravella wrote:
> > autofs version is autofs-3.1.7-21
> > 
> > I also have one new update. We started seeing similar problem on
> > the system running the kernel 2.4.18-e.12smp which has the same
> > version(3.1.7-21) of autofs as well.
> > 
> > This may or may not be an autofs problem but, restarting autofs
> > fixes this problem temporarily.
> > 
> 
> That will cause an NFS remount.  This really feels much more like an NFS
> problem.

Certainly does.

Venkata,

Can you also forward this question to the nfs list at 
nfs@lists.sourceforge.net. Sorry to ask you to post all over the place.

Please investigate the NFS client patches maintained by Trond Myklebust. 
Check nfs.sourceforge.net. We found we had to use them in early 2.4 versions.

Ian

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Automount/NFS issues causing executables to appear corrupted
Date: Mon, 19 Apr 2004 17:24:23 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40846DB7.4090102@zytor.com>
References: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
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
To: Venkata Ravella <Venkata.Ravella@synopsys.com>
Cc: autofs@linux.kernel.org, ab@californiadigital.com, Ramki.Balasubramanium@synopsys.com, linux-kernel@vger.kernel.org, raven@themaw.net

Venkata Ravella wrote:
> autofs version is autofs-3.1.7-21
> 
> I also have one new update. We started seeing similar problem on
> the system running the kernel 2.4.18-e.12smp which has the same
> version(3.1.7-21) of autofs as well.
> 
> This may or may not be an autofs problem but, restarting autofs
> fixes this problem temporarily.
> 

That will cause an NFS remount.  This really feels much more like an NFS
problem.

	-hpa

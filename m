From: raven@themaw.net
Subject: Re: Problem with Automount 4.1.x
Date: Tue, 4 May 2004 22:59:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405042257370.17014@donald.themaw.net>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE718D45BB@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE718D45BB@HOUEXC210.mgroupnet.com>
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
To: "Rigler, Steve" <SRigler@MarathonOil.com>
Cc: autofs@linux.kernel.org

On Tue, 4 May 2004, Rigler, Steve wrote:

> I'm experiencing an issue where automount v4.1.2 (before and after
> the most current patch) will not mount NFS dirs.  I'm pasting an
> "strace -f" of the automount process responsible for the automount
> dir.
> 
> This happens when we boot the machine (tested on RHEL 3 and FC1).
> It won't mount NFS dirs and will sometimes resolve itself (always
> after restarting the automount processes).
> 
> In the case of the strace, the mountpoint I'm trying to get to is
> "/software/OW12PL" which is defined in a yp map.  In messages I
> see this:
> 
> May  4 09:06:25 houu30 automount[1842]: attempting to mount entry /software/OW12PL
> May  4 09:06:36 houu30 automount[2763]: mount(nfs): no host elected
> May  4 09:06:36 houu30 automount[2763]: failed to mount /software/OW12PL

Steve could you add a --debug to the master map entry and send the log 
output from your debug.log please.

Ian

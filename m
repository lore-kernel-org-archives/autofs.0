From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Server IP address change screws up active mounts
Date: Tue, 18 May 2004 17:15:28 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40AAA720.9010000@zytor.com>
References: <134FC8D9C1F126488E3D123A9B2607370105E0F9@bp1houex002.bp1.ad.bp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <134FC8D9C1F126488E3D123A9B2607370105E0F9@bp1houex002.bp1.ad.bp.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Murata, Dennis W (SAIC)" <muratadw@bp.com>
Cc: autofs@linux.kernel.org, David Meleedy <david.meleedy@analog.com>, Ian Kent <raven@themaw.net>

Murata, Dennis W (SAIC) wrote:
> We experienced similar problems using autofs-3.x with both RedHat(7.3,
> 8.0, 2.1, 9.0) and Slackware(9.0).  This seems to be fixed with
> autofs-4.x.  We have used 4.0.0-pre10 for a couple of years without
> problem and are now trying 4.1.2.
> The problems we were seeing dealt with and automounted nfs server not
> responding, the mount would hang, autofs would not timeout and would
> hang, only a hard reset would reboot the computer.
> 

It wouldn't have anything to do with autofs, though.  Rather, it's an 
NFS problem.

	-hpa

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Fri, 09 Jan 2004 13:36:04 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF1EC4.7080406@zytor.com>
References: <3FFC96FE.9050002@zytor.com>
	<Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
	<20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
	<3FFF03EA.4060603@sun.com> <3FFF07B2.70801@zytor.com>
	<3FFF1DA7.8060005@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FFF1DA7.8060005@sun.com>
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
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>, viro@parcelfarce.linux.theplanet.co.uk, "Ogden, Aaron A." <aogden@unocal.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Ian Kent <raven@themaw.net>

Mike Waychison wrote:
>
> Unless I'm missing something, implementing this as a seperate filesystem
> type still has the appropriate atomicity guarantees as long as the VFS
> support complex expiry, whereby userspace would tag submounts as being
> part of the overall expiry for a base mountpoint.
> 

It would, but it seems like a vastly more invasive change to the VFS
than ought to be necessary.

	-hpa

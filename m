From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trapping eject button on CD-ROM
Date: Sun, 14 Mar 2004 11:01:03 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4054ABEF.3050608@zytor.com>
References: <20040314164051.27220.qmail@web20503.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040314164051.27220.qmail@web20503.mail.yahoo.com>
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
To: Jon Niehof <jon_niehof@yahoo.com>
Cc: autofs@linux.kernel.org

Jon Niehof wrote:
> Apologies if this has been asked before; I read a
> HOWTO that seemed to imply it was possible but haven't
> seen anything beyond that.
> 
> Is it possible to configure autofs to "catch" the
> eject button on a CD-ROM and unmount the filesystem
> (presuming it's not busy, of course), then eject?
> 

No.

If you monitor insert and eject you don't want autofs anyway.  You want 
something like what Solaris calls "vold".

	-hpa

From: raven@themaw.net
Subject: Re: Is autofs4 8-bit compatible?
Date: Sun, 3 Apr 2005 11:48:06 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504031146420.8220@donald.themaw.net>
References: <424F683D.000001.08082@tide.yandex.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <424F683D.000001.08082@tide.yandex.ru>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: atlantos41 <atlantos41@yandex.ru>
Cc: autofs@linux.kernel.org

On Sun, 3 Apr 2005, atlantos41 wrote:

>
> I tried this patch and now automount mounts all shares. But automount can't umount mounted shares with 8-bit chars in share names - I have entries in syslog like (I start autofs with command `automount --timeout=60 --verbose /smb file /etc/auto.smb``):

Thanks.
At least it's a step forward.

I'll keep on it.

Ian

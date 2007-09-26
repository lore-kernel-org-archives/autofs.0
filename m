From: Ian Kent <raven@themaw.net>
Subject: Re: [BUG] 5.0.0_beta1: infinite loop on read error
Date: Wed, 26 Sep 2007 23:12:53 +0800
Message-ID: <1190819573.12109.9.camel@raven.themaw.net>
References: <200709261105.14333.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261105.14333.vda.linux@googlemail.com>
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
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-09-26 at 11:05 +0100, Denys Vlasenko wrote:
> Hi Ian,
> 
> I was using automount 4.1.4 for many years now, and I run it like this:
> 
> automount -f -s -v --timeout 15 /.local/mnt/auto program /root/bin/mapper.sh
> 
> This is a valid syntax for 4.1.4, but 5.0.0 doesn't like it, and it doesn't
> error out cleanly too.
> 
> It goes into infinite loop, eating 100% CPU and killable only with SIGKILL.
> As it turns out, it opens /.local/mnt/auto and reads it, and gets EISDIR,
> and ... retries, retries, retries forever. Here:

Ooops, I'll fix that.
Thanks

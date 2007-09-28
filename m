From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] 5.0.0_beta1: use PATH in execXX()
Date: Fri, 28 Sep 2007 17:11:25 +0800
Message-ID: <1190970685.11447.6.camel@raven.themaw.net>
References: <200709261100.54397.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261100.54397.vda.linux@googlemail.com>
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

On Wed, 2007-09-26 at 11:00 +0100, Denys Vlasenko wrote:
> I think it's reasonably safe since automount is started by root
> and root is expected to set PATH sanely.
> 
> And it still doesn't work, because you are using execv(), not execvp().
> 
> This patch replaces execv() with execvp().
> 
> It should change nothing for 'normally' configured automount since
> it passes fully qualified names ("/bin/mount") to exec and PATH
> is not used in this case.

I still can't agree that using $PATH to locate executable maps is OK.
If a system uses executable maps then I think the location of them
should be specified in full.

Ian

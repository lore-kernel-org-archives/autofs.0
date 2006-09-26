From: Ian Kent <raven@themaw.net>
Subject: Re: White spaces in mount point
Date: Wed, 27 Sep 2006 00:37:55 +0800
Message-ID: <1159288675.27996.15.camel@raven.themaw.net>
References: <b688507b0609260603o4c94a308ke3bc394966fdbc53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <b688507b0609260603o4c94a308ke3bc394966fdbc53@mail.gmail.com>
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
To: Kfir Lavi <lavi.kfir@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2006-09-26 at 16:03 +0300, Kfir Lavi wrote:
> Hi,
> I have this problem:
> When I try to mount samba share with white spaces, I get an error:
> Sep 26 15:40:20 [automount] failed to mount /tmp/explorer/test1/AAA_My Pictures
> 
> My auto.aaa file:
> "AAA_My Pictures" -fstype=smbfs,ro :"//AAA/My Pictures"
> 
> Tried without the quotes:
> AAA_My Pictures -fstype=smbfs,ro ://AAA/My Pictures
> 
> How can I mount share names that have white spaces?

So I would guess you're using version 4?
Try
AAA_My\ Pictures -fstype=smbfs,ro ://AAA/My\ Pictures

and see if that helps

Ian

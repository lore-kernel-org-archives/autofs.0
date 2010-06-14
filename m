From: Ian Kent <raven@themaw.net>
Subject: Re: Executable maps
Date: Mon, 14 Jun 2010 12:44:51 +0800
Message-ID: <1276490691.9943.68.camel@localhost>
References: <AANLkTin8PTdQLShcrAk_cT21pFfwcuatXvMNMQSgYmO3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=ypqxzjO6y8YEV2NIuAequNfNOW0=;
	b=m+GlT6QIVvFwTRvyRwEXCD6w2D1+G2YELNyPdcFPLoLJ3/8dgmZTkiOWdD2TdI7Akb/c/aK8lEeX9GKFrHYF+kP+0s/PR655Xdr0wL2KCeoidRZdka452aBxtjwvd1heJnNiMMjWktJ07JbZc1ocZcpHDgIbXCh/nnbIXS0GuhA=
In-Reply-To: <AANLkTin8PTdQLShcrAk_cT21pFfwcuatXvMNMQSgYmO3@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Techie <techchavez@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2010-06-07 at 16:33 -0700, Techie wrote:
> Hi Ian, List,
> 
> 2 questions..
> 
> 1) Has a fix been released for the Admin or "$" shares in regards to
> cifs yet? The automounter fails to mount them even though the path
> looks ok. It mounts the non admin shares fine. I can mount them fine
> from the CLI.

Not sure, since there was no feedback from the thread:
http://www.mail-archive.com/autofs@linux.kernel.org/msg07896.html

but the patch posted there has been committed and is available on
kernel.org. There may well be other patches in the series that it
depends on so beware.

> 
> 2) I have modified the auto.smb script to create a direct map since
> the indirect fails to mount admin shares. Can a direct map be used as
> an executable map? My feeling from my reading of the manpage is no but
> maybe there is a way.

Don't think that could work.
There's no way for a program map to enumerate the entire map at initial
startup and I don't want to add something that allows that because
program maps are dynamic and that introduces all sorts of difficulties
for the handling of direct mounts. And there is no way to use a program
map for a direct mount that has not been mounted (at startup).

Ian

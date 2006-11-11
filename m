From: Ian Kent <raven@themaw.net>
Subject: Re: autofsv5 - mouting files (not dirs)
Date: Sat, 11 Nov 2006 10:58:16 +0800
Message-ID: <1163213896.3113.19.camel@localhost>
References: <44AE7785.74E63D70@ggr.co.uk> <4554696C.5030400@ggr.co.uk>
	<45546B1F.5030306@ggr.co.uk>  <4554B7F4.3050909@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4554B7F4.3050909@ggr.co.uk>
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
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

On Fri, 2006-11-10 at 17:33 +0000, Gordon Lack wrote:
>     The automount code (at least for indirect mounts) will not mount an 
> entry which is a file - it has to be a directory.
> 
>     The reason behind this is that the code first creates the directory 
> then tries to mount the remote object on it.
> 
>     In order to mount a remote file you need to mount it over a file, 
> not a directory.  (As far as I can tell, mounting a file on a file works 
> OK in Linux).
> 
>     Would it be possible to get automount to retry on a file if it gets 
> ENOTDIR from the remote end?

You got me there. I'm not sure about mounting on files at this stage.

I think there's probably a bit more to change than just the create
directory function.

Ian

From: Ian Kent <raven@themaw.net>
Subject: Re: excluding some pattern to prevent useless mount	request
Date: Tue, 28 Nov 2006 02:42:35 +0800
Message-ID: <1164652955.24892.12.camel@localhost>
References: <456B1516.1030108@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <456B1516.1030108@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Mon, 2006-11-27 at 17:40 +0100, Guillaume Rousse wrote:
> While looking in server's log, I found many such mount requests:
> Nov 26 04:23:19 yquem rpc.mountd: refused mount request from
> chouchen.inria.fr for /home/yquem/.hidden (/): no export entry
> ...
> Nov 26 04:22:33 yquem rpc.mountd: refused mount request from
> medoc.inria.fr for /home/yquem/.directory (/): no export entry
> 
> I guess they are caused by graphical file manager trying to find
> metadata directories when displaying mount points. Is there a way to
> prevent them ?

This looks like a problem with hald.
Try updating it.

Ian

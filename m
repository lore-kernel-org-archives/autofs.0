From: raven@themaw.net
Subject: Re: program mount problem
Date: Thu, 19 Aug 2004 23:16:33 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408192315410.18842@donald.themaw.net>
References: <200408171008.26436.gmishkin@acs.bu.edu>
	<4124A26C.6090300@rhythm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4124A26C.6090300@rhythm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

On Thu, 19 Aug 2004, Greg Bradner wrote:

> I just installed 4.1.3 with the autofs4-2.4.22-20040508.patch.  I have a 
> server with 10 mount points and I only have permission to mount 1.  If I 
> cd to one I don't have permission to, I get permission denied in the 
> syslog, but it will keep 'looping' the name of the mount.
> 
> the mount is /n3 - a program mount
> the server is ns16 - 10 mounts exported
> no permissions to mount e
> 
> cd /n3/ns16/e/n3/ns16/e/n3/ns16/e/n3/ns16/e/
> 
> At end, I hit tab for file completion and will loop /n3/ns16/e over and 
> over - were it would just stop at one /n3/ns16/e with autofs-4.1.0.
> I am running redhat 7.3 and a 2.4.26 kernel.

Could you get some debug log output please.

Ian

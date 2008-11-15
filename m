From: Ian Kent <raven@themaw.net>
Subject: Re: Caching negative lookups
Date: Sat, 15 Nov 2008 19:25:39 +0900
Message-ID: <1226744739.2936.5.camel@zeus.themaw.net>
References: <e28c2a430811030703w654ffafcuf47a95b450e6de37@mail.gmail.com>
	<1226628492.2906.15.camel@zeus.themaw.net>
	<e28c2a430811140527g7fbfb49aj652a1bfc4df3e5e1@mail.gmail.com>
	<1226670263.2906.38.camel@zeus.themaw.net>
	<1226670596.2906.40.camel@zeus.themaw.net> <491D9B06.80605@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <491D9B06.80605@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-11-14 at 16:36 +0100, Ondrej Valousek wrote:
> I do not understand it - I have heard that using indirect maps can cause
> unwanted NFS chattering on the network and that negative lookups are
> supposed to handle this.
> But this chattering I can only imagine when using wildcards like
> /home auto.home
> with auto.home containing something like:
> * nfsserver:/vol/vol0/users/&
> 
> This way, if an application check for the existence of say /home/file -
> the automounter must ask nfsserver for existence of this file every time
> the application asks. But if there are no wildcards in the indirect map
> and all valid entries are explicitly listed, no nfs chattering occurs as
> autofs knows directly that the mount attempt for  /home/file is invalid
> as there is no "file" record in the auto.home map.
> 
> Am I right? If yes, that would be a serious argument against using
> wildcards in the automount maps.....

Not really.

The issue that Mike is concerned about is the actual check against the
yp map for the key consuming sockets. Given that when an application
attempts to access a directory in an indirect map the kernel is
obligated to send a request to the daemon. If the daemon isn't properly
recording previous mount fails (and in this case also recording requests
for non existent keys) and continually trying to mount or find the key
then there can be quite a bit of traffic. This is the whole idea of the
timeout for negative (failed) requests

Ian

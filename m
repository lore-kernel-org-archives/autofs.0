From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Caching negative lookups
Date: Fri, 14 Nov 2008 16:36:38 +0100
Message-ID: <491D9B06.80605@s3group.cz>
References: <e28c2a430811030703w654ffafcuf47a95b450e6de37@mail.gmail.com>	<1226628492.2906.15.camel@zeus.themaw.net>	<e28c2a430811140527g7fbfb49aj652a1bfc4df3e5e1@mail.gmail.com>	<1226670263.2906.38.camel@zeus.themaw.net>
	<1226670596.2906.40.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1226670596.2906.40.camel@zeus.themaw.net>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

I do not understand it - I have heard that using indirect maps can cause
unwanted NFS chattering on the network and that negative lookups are
supposed to handle this.
But this chattering I can only imagine when using wildcards like
/home auto.home
with auto.home containing something like:
* nfsserver:/vol/vol0/users/&

This way, if an application check for the existence of say /home/file -
the automounter must ask nfsserver for existence of this file every time
the application asks. But if there are no wildcards in the indirect map
and all valid entries are explicitly listed, no nfs chattering occurs as
autofs knows directly that the mount attempt for  /home/file is invalid
as there is no "file" record in the auto.home map.

Am I right? If yes, that would be a serious argument against using
wildcards in the automount maps.....
Ondrej

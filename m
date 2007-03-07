From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: direct mount from NFS-mounted directories issue
Date: Wed, 07 Mar 2007 10:27:57 +0100
Message-ID: <45EE859D.8020407@inria.fr>
References: <45ED676E.8020904@inria.fr>
	<1173200232.3629.27.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1173200232.3629.27.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> This behavior was changed because the NFS client in recent kernels
> return EACCESS before it returned EEXIST. It would have been fine to
> just use stat(2) and then create the mount point directory but that
> attracted much criticism regarding the security aspects of "root" owned
> code to attempting to create directories on a remote NFS server. And so
> this is the way it is now.
I'm not a security expert, but it seems for me than allowing root owned
code to create anything on the server is rather a question of
configuring the export writability and trustability on root uid than
enforcing it on client side. Anyway, could the client behaviour be
configurable also, with current (secure) behaviour as default ?

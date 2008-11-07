From: Ian Kent <raven@themaw.net>
Subject: Re: expire_indirect errors in the syslog
Date: Fri, 07 Nov 2008 10:20:30 +0900
Message-ID: <1226020830.3093.22.camel@zeus.themaw.net>
References: <4906C365.8030209@s3group.cz>
	<1225181075.2938.97.camel@zeus.themaw.net>
	<4906CB2A.9010705@s3group.cz>
	<1225192753.2938.103.camel@zeus.themaw.net>
	<4912E18F.7010701@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4912E18F.7010701@s3group.cz>
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

On Thu, 2008-11-06 at 13:22 +0100, Ondrej Valousek wrote:
> Ok, I have removed all "nohide" options from my exports, but I am still
> experiencing the expire_indirect errors.
> I must also say that I am also using NetApp NAS and one share is nfs4
> mounted.
> But I do not believe it is NetApp/nfs4 related.
> 
> Question:
> Is it possible that I receive this errors when:
> 1. say I have autofs key like "share nfsserver:/exports/share"
> 2. some processes start using the share
> 3. I delete the key above and delete the share from the NFS server
> 4. As the share no longer exists but some processes are still using it,
> automounter can not unmount it, so I manually invoke umount -l to remove it.

This specific example should not result in those messages.
If you want further analysis of this issue then post a full debug log.

Ian

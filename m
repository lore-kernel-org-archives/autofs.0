From: Ian Kent <raven@themaw.net>
Subject: Re: auto.net-like script for smbfs?
Date: Mon, 1 Dec 2003 14:07:50 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0312011405280.22187-100000@wombat.indigo.net.au>
References: <20020128221855.A28232@pingu.tti>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20020128221855.A28232@pingu.tti>
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
To: Christoph Bugel <chris@tti-telecom.com>
Cc: autofs@linux.kernel.org

On Mon, 28 Jan 2002, Christoph Bugel wrote:

>
> Is there a script that uses smbclient -L or something to
> figure out the available shares on a given windows smb host,
> similar to the auto.net script that uses showmount to figure
> out the available mountpoints for a given NFS host?

No. Not yet.

>
> The goal is to have a /smb directory that will function just
> like my NFS /net directory..
>
> currently I have auto.misc with the line
> *  -fstype=smbfs,username=guest,password= ://&/c
> But not all shares are called "C". I guess there is no
> catch-all solution for the password thing, but maybe someone
> has written the script for finding the shares?

No. I have never been able to satisfactorily use SMB shares in a 'real'
domain environmnet. I have tried enough to not want do any more.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

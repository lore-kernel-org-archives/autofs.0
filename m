From: Ian Kent <raven@themaw.net>
Subject: Re: Re: auto.net-like script for smbfs?
Date: Tue, 2 Dec 2003 09:14:46 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0312020912420.11316-100000@wombat.indigo.net.au>
References: <3FCBB813.50101@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FCBB813.50101@sun.com>
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
To: Soyoung Park <Soyoung.Park@Sun.COM>
Cc: autofs@linux.kernel.org, Christoph Bugel <chris@tti-telecom.com>

On Mon, 1 Dec 2003, Soyoung Park wrote:

> >
> i'm a little confused.
>
> i've gotten smb mount to work w/ autofs, but not used any script.
>
> what i did was:
>
> 1. create a share dir in my window machine for file share access
> 2. add an auto.smb file w/ line
> "-fstype=smbfs,username=username,password=password:\\path" and
> 3. motify auto.master to include auto.smb
>
> and i was copying files across smb w/ the smb folder auto mounted.
>
> the windows machine had to be password protected.
>

I got the impression that someone was talking about using the anonymous
share (no passwords) which is rearly avaialble in most places.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

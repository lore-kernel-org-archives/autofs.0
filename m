From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Automounter losing track of mounts...
Date: Fri, 15 Aug 2008 12:10:01 +0200
Message-ID: <48A555F9.1020808@s3group.cz>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>	<48A33032.1060506@aei.mpg.de>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58CA@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A58CA@hqemmail01.nvidia.com>
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
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org


>> We had a related issue quite a bit and /etc/mtab and 
>> /proc/mounts went out of sync. Right now we are symlinking 
>> /etc/mtab to /proc/mounts. It works, but I don't know if 
>> that's the best solution for it.
>>     
>
> Yes, we could do that and that seems to be a canonical solution that is
> even talked about in the 'man' pages.  But, there may be a problem with
> that.
>
> Have you seen any cases where different processes are specifically
> writing either to /etc/mtab _or_ /proc/mounts in an asynchronous manner?
> Since it would now be the same file due to it being symlinked, what
> would that sort of write access do to the integrity of the mount tables?
> Would it even matter?
>
>   
1. You can not write to /proc/mounts as it is read only
2. mount.nfs is broken (bug already filed) the way that it can not
handle symlink /etc/mtab -> /proc/mounts properly.
3. I believe content handling of /proc/mounts is the kernel's job. If it
does not do it well, it should be patched -> we should not patch
automounter as it is not its responsibility. The similar with /etc/mtab
- it is the mount responsibility to handle it.

HTH

Ondrej

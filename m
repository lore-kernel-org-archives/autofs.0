From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: autofs unmount don't work with symbolic links
Date: Sat, 30 Oct 2004 23:17:04 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200410302317.04738.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: apon@isd.dp.ua, autofs@linux.kernel.org

On Tuesday 26 October 2004 11:33, Alexander Ponomarenko wrote:
>     Hello!
>     I found the trouble when I tryed to use autofs on linked var
> filesystem. My /var is simbolic link to /usr/var. My filesystems
> successfully mounts but didn't unmounts on expiration time.
>     If I use full path in config files (/uar/var/autofs not simply
> /var/autofs) all is OK.
> 
>     My operating system is Debian GNU/Linux:
>         Linux IAPonomarenko 2.6.6-asp #1 Fri Jul 2 11:52:26 EEST 2004
> i686 GNU/Linux.
> 
>     I think this information may be usefull for other people.

I saw the same on 4.0.0pre10. I worked around by substituting
the path symlink points to.

I didn't check this on 4.1.3 (forgot about the issue)

Which version is yours?
--
vda

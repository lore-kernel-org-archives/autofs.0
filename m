From: Alexander Ponomarenko <apon@isd.dp.ua>
Subject: autofs unmount don't work with symbolic links
Date: Tue, 26 Oct 2004 11:33:38 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua>
Reply-To: apon@isd.dp.ua
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

    Hello!
    I found the trouble when I tryed to use autofs on linked var
filesystem. My /var is simbolic link to /usr/var. My filesystems
successfully mounts but didn't unmounts on expiration time.
    If I use full path in config files (/uar/var/autofs not simply
/var/autofs) all is OK.

    My operating system is Debian GNU/Linux:
        Linux IAPonomarenko 2.6.6-asp #1 Fri Jul 2 11:52:26 EEST 2004
i686 GNU/Linux.

    I think this information may be usefull for other people.

--
Alexander Ponomarenko

From: Brian Long <brilong@cisco.com>
Subject: Re: direct map shut down?
Date: Thu, 19 Feb 2004 12:21:41 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1077211301.19371.34.camel@brilong-lnx2.cisco.com>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1077211015.19371.32.camel@brilong-lnx2.cisco.com>
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

As a follow-up, /var/log/messages lists the following:

Feb 19 12:07:03 machello automount[1600]: starting automounter version 4.1.0, path = /misc, maptype = file, mapname = /etc/auto.misc
Feb 19 12:07:03 machello automount[1620]: starting automounter version 4.1.0, path = /tools, maptype = nisplus, mapname = auto_tools
Feb 19 12:07:03 machello automount[1646]: starting automounter version 4.1.0, path = /auto, maptype = file, mapname = /etc/auto.indirect
Feb 19 12:07:03 machello automount[1678]: starting automounter version 4.1.0, path = /users, maptype = nisplus, mapname = auto_home
Feb 19 12:07:03 machello automount[1620]: using kernel protocol version 4.03
Feb 19 12:07:03 machello automount[1620]: using timeout 300 seconds; freq 75 secs
Feb 19 12:07:03 machello automount[1646]: using kernel protocol version 4.03
Feb 19 12:07:03 machello automount[1646]: using timeout 300 seconds; freq 75 secs
Feb 19 12:07:03 machello automount[1600]: using kernel protocol version 4.03
Feb 19 12:07:03 machello automount[1600]: using timeout 60 seconds; freq 15 secs
Feb 19 12:07:03 machello automount[1678]: using kernel protocol version 4.03
Feb 19 12:07:03 machello automount[1678]: using timeout 300 seconds; freq 75 secs
Feb 19 12:07:03 machello automount[1708]: starting automounter version 4.1.0, path = /-, maptype = file, mapname = /etc/auto.direct
Feb 19 12:07:03 machello autofs: automount startup succeeded
Feb 19 12:07:03 machello automount[1708]: shut down, path = /-

Thanks for any help you can provide.

/Brian/
-- 
       Brian Long                      |         |           |
       Americas IT Hosting Sys Admin   |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s

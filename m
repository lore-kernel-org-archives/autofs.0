From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Subject: Re[2]: autofs reload
Date: Fri, 26 Mar 2004 20:27:10 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B6v6s-000EvK-00.ia6432-inbox-ru@f13.mail.ru>
References: <40646141.2040809@sun.com>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40646141.2040809@sun.com>
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
To: =?koi8-r?Q?=22?=Mike Waychison=?koi8-r?Q?=22=20?= <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org

On Fri, 26 Mar 2004 at 11:58:41 -0500, Mike Waychison wrote:

> Ian responded to this a while back, see his answer at:
> http://linux.kernel.org/pipermail/autofs/2004-February/000932.html
thanks! missed this one...

> "That's right because, for file, NIS and LDAP maps, the daemon uses a
> cache that is not aware of updates.
> 
> In 4.1.0 you can send a HUP signal to the daemon process controling the
> map to ask it to update the map in similar fashion to running automount
> on Solaris."
then maybe we should do this on autofs reload instead of restarting
daemons?

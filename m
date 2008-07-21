From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs doesn't look at second LDAP server
Date: Mon, 21 Jul 2008 12:30:22 +0800
Message-ID: <1216614624.3093.0.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org


On Wed, 2008-07-16 at 09:20 +0800, Coe, Colin C. (Unix Engineer) wrote:
> Hi all
> 
> I've noticed that, after a period of stability, autofs is dumping core
> again.
> 
> The common thread is the time the core dumping happens, 4AM (give or
> take a few minutes) which is when our 'cron daily' process runs.  This
> 'cron daily' lives on an NFS mount that is in the auto_global map
> ('/nfs/appl server:/vol/oldserver_appl').

Are you able to duplicate this?
IOW, does it happen predicatably?

Ian

From: Brian Long <brilong@cisco.com>
Subject: Re: questions on auto.master file format
Date: Thu, 04 Mar 2004 09:06:55 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1078409214.29340.33.camel@brilong-lnx2.cisco.com>
References: <16452.51314.769206.991484@segfault.boston.redhat.com>
	 <Pine.LNX.4.58.0403031455220.16583@wombat.indigo.net.au>
	 <16453.61187.553910.939557@segfault.boston.redhat.com>
	 <Pine.LNX.4.58.0403041224300.7374@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403041224300.7374@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


> > Have I misinterpreted this?  Looks to me like nosuid is a mount option.
> 
> Oops. My mistake.

But you're relying on Sun's documentation :-)  We don't use the options
like they document, but our auto_master is in NIS+:

/auto /etc/auto.indirect -grpid
/users auto_home -rw,hard,intr

Before implementing this feature, I'd much prefer to see layered direct
mounts  ;-)

/Brian/

-- 
       Brian Long                      |         |           |
       Americas IT Hosting Sys Admin   |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s

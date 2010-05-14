From: "Murata, Dennis" <DENNIS.MURATA@saic.com>
Subject: Re: Browse mode in autofs 5
Date: Fri, 14 May 2010 15:28:33 -0700
Message-ID: <620E93B2E5CC3B46BD811165E3335B87088822BB@0461-its-exmb02.us.saic.com>
References: <620E93B2E5CC3B46BD811165E3335B87088195CC@0461-its-exmb02.us.saic.com>
	<1273742969.2305.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1273742969.2305.11.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Added nobrowse to the auto.master, seems to be working.  Will check with
RHEL4 clients.
Wayne 

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Thursday, May 13, 2010 4:29 AM
To: Murata, Dennis
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Browse mode in autofs 5

On Wed, 2010-05-12 at 17:15 -0700, Murata, Dennis wrote:
> Is there any way to turn off browse mode on specific nfs mounts using 
> autofs 5?  We are running a modified RHEL5U5, 
> autofs-5.0.1-rc2.143.el5, kernel-2.6.18-194.el5.  The users want the 
> data mounts to be browseable so they can see the possible directories,

> but we don't want /home to be browseable.  The KDE and Gnome file 
> managers will cause all home directories to mount if the user looks at

> /home.  That would cause over 2000 mount requests.  In RHEL4 autofs4, 
> we could specify which directories to browse, I don't see this option
in autofs5.

You can specify the option in the master map entry.
I seem to remember that was also the case with v4 if you wanted
selective browseable maps.

The default installed configuration makes autofs managed mounts not
browsable when no option is given in the master map, as it is the case
in v4. The options browse and nobrowse are used in other industry autofs
products and they are the recommended options to use, although the
--ghost option can be used in instead of the browse option.

Ian

From: Risto Bell <reb@cypress.com>
Subject: autofs-4.1.3-150: Spooky ghosting benefit?: Less HUP's to
 refresh NIS maps
Date: Tue, 02 Oct 2007 14:52:50 -0700
Message-ID: <4702BDB2.3040906@cypress.com>
References: <mailman.1.1162296001.31020.autofs@linux.kernel.org>
	<45478B5A.7000106@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45478B5A.7000106@cypress.com>
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
To: autofs@linux.kernel.org

Using autofs-4.1.3-150 on RedHat Enterprise 3 Update 6 with maps
in NIS. Servers primarily are: NETAPP, RHEL3-U6, or dwindling RH7.3.
Our NFS clients tend to lead NFS servers in OS upgrades. Also keep
RH automount timeout default of 60sec.

man automount:
   "The daemon also responds to a HUP signal which triggers an
update of maps for which ghosting is implemented (currently
FILE and NIS maps)."

Traditionally our linux NSF clients have troubles when NIS maps are
edited, and (without NIS map edit) when remote partitions are resized.
Requiring HUP of all clients (and if the mount was in use, the HUP
doesn't work on that daemon, the client as a CPU-server is in trouble,
needing careful manual killing of applications and/or reboot).
(Autofs I'll agree can't cause active mount failures on resize).

This was so especially without ghosting on. (Can say man page
technically doesn't say ghosting must be turned-on, only available
as theoretical option on that type of map; though easily mis-readable
to imply ghosting must be turned on).

However, reports from the field are that with ghosting enabled, the
need for HUP-ing clients is very much less. So much so that this is
viewed as the *dominant* benefit of ghosting. Compared to showing the
appearance of the dirs before mounted (which was not enough to trigger
us to enabled ghosting), this greater reliability from ghosting leading
to much fewer reboots and downtime: justifies distributing an update.

I'm thankful for this side-effect of course. Man page is silent about it.
Can anyone confirm this side-effect was observed or expected, or suggest
other reasons for it?

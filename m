From: "Murata, Dennis" <DENNIS.MURATA@saic.com>
Subject: Browse mode in autofs 5
Date: Wed, 12 May 2010 17:15:30 -0700
Message-ID: <620E93B2E5CC3B46BD811165E3335B87088195CC@0461-its-exmb02.us.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org

Is there any way to turn off browse mode on specific nfs mounts using
autofs 5?  We are running a modified RHEL5U5, autofs-5.0.1-rc2.143.el5,
kernel-2.6.18-194.el5.  The users want the data mounts to be browseable
so they can see the possible directories, but we don't want /home to be
browseable.  The KDE and Gnome file managers will cause all home
directories to mount if the user looks at /home.  That would cause over
2000 mount requests.  In RHEL4 autofs4, we could specify which
directories to browse, I don't see this option in autofs5.

Thanks
Wayne

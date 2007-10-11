From: John Simon <tzzhc4@yahoo.com>
Subject: Has replicated mount failover  been implemented?
Date: Wed, 10 Oct 2007 23:28:21 -0700 (PDT)
Message-ID: <836836.16914.qm@web81813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

We are in the process of switching from Sun blades to
Linux blades for our compute farm and are running into
issues with automount not failing over when an NFS
server goes down. I am wondering if it is a
configuration issue, if I am using a version of autofs
that doesn't support failover or if it hasn't been
implemented yet.

Currently I am running SLES 10 with autofs 4.1.4. Here
are my configs. The server will pick the next host in
line at mount but if the failure happens after mount
the mount does NOT failover. Any information would be
greatly appreciated.:


/etc/auto_appl

test
-rsize=32768,wsize=32768,nfsvers=3,tcp,retrans=5,timeo=600
test-ap01,test-ap02,test-ap03:/export/appl/test

/etc/auto.master

/appl   /etc/auto_appl -rw,intr,nosuid,nobrowse
/apps   /etc/auto_apps -ro,intr,nosuid,nobrowse
/home   /etc/auto_home -rw,intr,nosuid,nobrowse


/etc/sysconfig/autofs

AUTOFS_OPTIONS="--timeout 3600"


      ____________________________________________________________________________________
Tonight's top picks. What will you watch tonight? Preview the hottest shows on Yahoo! TV.
http://tv.yahoo.com/ 

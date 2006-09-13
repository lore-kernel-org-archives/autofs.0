From: "Brine, KR \(Keith\)" <K.R.Brine@rl.ac.uk>
Subject: Automounts not working
Date: Wed, 13 Sep 2006 12:13:23 +0100
Message-ID: <57BFD82EEF0CDE41A72C4EDADF8A01B2031382B5@exchange27.fed.cclrc.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: redhat-list@redhat.com
Cc: autofs@linux.kernel.org

Did you get a fix for "Automounts not working"

I have the same errors... it only started recently (may be since
upgrading Red Hat)
I am using: Linux #1 SMP Wed Jul 12 23:32:02 EDT 2006 x86_64 GNU/Linux
I had been pulling my automount maps from my Sun NIS+ server running
Solaris 7... worked fine.

I now have a work around .... reconstructed the automount files in /etc
auto.master and auto.another (referred to by auto.master).
Had to change the /etc/nsswitch.conf file from "automount: files nis" to
just "automount: files".
The errors I get when trying to use NIS+ tables are :

Starting automount: do_ypcall: clnt_call: RPC: Procedure unavailable
do_ypcall: clnt_call: RPC: Procedure unavailable
do_ypcall: clnt_call: RPC: Procedure unavailable
do_ypcall: clnt_call: RPC: Procedure unavailable
do_ypcall: clnt_call: RPC: Procedure unavailable
do_ypcall: clnt_call: RPC: Procedure unavailable
No Mountpoints Defined                                     [  OK  ]

 
Keith Brine 
ISIS PEG Group, R2 2.07 
Rutherford Appleton Laboratory 
(01235 44 5499 
Keith.Brine@rl.ac.uk 

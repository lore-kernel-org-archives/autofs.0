From: Omri Schwarz <ocschwar@MIT.EDU>
Subject: Program maps in Autofs version 5.
Date: Wed, 30 May 2007 17:49:42 -0400 (EDT)
Message-ID: <Pine.GSO.4.64L.0705301742100.6143@home-on-the-dome.mit.edu>
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

Hi, all. I am trying to test program maps for a legacy-ridden environment,
and am going step by step through this article from Developer Works:

http://www.ibm.com/developerworks/aix/library/au-namespace/index.html

It fails immediately because as this program map shows,
$PWD is not set. auto.master says:

/TEST	/etc/auto.prog

auto.prog says:
#!/bin/bash
echo $1 | logger -t autofs-test
echo $PWD |logger -t autofs-test
printenv | logger -t autofs-test

$PWD turns out to be /, and nothing in the environment
of the automounter mentions /TEST.

So, is there a way to do this?
(I am using FC 6 with the autofs provided by the RPM)


Omri Schwarz --- ocschwar@mit.edu
Timeless wisdom of biomedical engineering: "Noise is principally
due to the presence of the patient." -- R.F. Farr

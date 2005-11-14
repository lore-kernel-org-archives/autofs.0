From: Hans Deragon <hans@deragon.biz>
Subject: auto.net gets a key with a path under SLES9.
Date: Mon, 14 Nov 2005 15:03:38 -0500
Message-ID: <4378ED9A.6090903@deragon.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Greetings.


   I compiled autofs 4.1.4 for SuSE Linux Enterprise Server 9 (SLES9). 
I did found a little problem with auto.net.  The original code has:

   key=$1

   However, under SLES9, in my network environment, $key can be of the 
form "server/something[/otherthing]*", which is wrong.  $key should only 
be a server name.  I fixed the problem with:

   key=`echo $1 | perl -wp -e 's%^(\w+)(\/?.+)*$%$1%;'`

   My fix removes any path after the server name.

   Exactly why automount passes a server name containg some path is 
unclear for me.  But I wanted to report this here.  If other suffer from 
this, you might want to consider some fix like mine (maybe using sed 
which is more standard).

   I have not experienced this under Fedora Core 4 (FC4).


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.
http://www.deragon.biz        Open source (contribution):
mailto://hans@deragon.biz     http://autopoweroff.deragon.biz

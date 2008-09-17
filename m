From: Joe Pruett <joey@clean.q7.com>
Subject: latest autofs from centos 4
Date: Tue, 16 Sep 2008 17:22:31 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
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

it looks like some recent changes to both autofs v4 and v5 has caused the 
siogcifconf buffer to be only 128 bytes.  this means that on our servers, 
it can't correctly match a local address since that is only enough room 
for 3 addresses and we're in the middle of a renumbering so we have 5-10 
addresses per machine.  this was working fine until i just updated to 
centos 4.7.  from looking at the code, it looks like someone created a 
MAX_IF_BUF #define at 2048, but didn't use it for the ioctl call.  is that 
a mistake?

i'll try a patched rpm locally and make sure this is the source of my 
woes.

From: Al Alder <aalder@ti.com>
Subject: multiple hostnames in automounter table
Date: Wed, 23 Jun 2004 14:33:10 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40D9DAF6.1010403@ti.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Are there any plans for the automounter to be able to handle multiple
hostnames in the automount table for Linux?  With Mandrake 10.0 the
automount daemon will not mount an entry that has multiple hostnames.
On Red Hat Enterprise 3.0, it gives a warning, but will mount using the
first hostname, is this functionality a RedHat thing that hasn't been shared
with the rest of the community or is Mandrake 10.0 just using a 
different/older
version?  Is there anyway around this problem, or to get Mandrake automount
to mount the first hostname? 

Your help is appreciated.

-- 

Later,

Al Alder
aalder@ti.com
214/480-3996

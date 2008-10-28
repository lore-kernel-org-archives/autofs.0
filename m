From: Nail El-Sourani <sourani@math.uni-muenster.de>
Subject: open_lookup:95: cannot open lookup module ldap
Date: Tue, 28 Oct 2008 10:41:31 +0100
Message-ID: <4906DE4B.1080805@math.uni-muenster.de>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi Ian and list,

i am on opensuse 10.3 and the packaged automounter version was 5.0.2 
which was not sufficient for me because of various bugs fixed in 5.0.3. 
So i got the Source from the kernel.org archive with all 5.0.3 patches 
and patch_order. applied and installed successfully, but receive the 
following error messages in the syslog with autofs logging on "debug" 
and no working automounts


automount[3347]: open_lookup:95: cannot open lookup module ldap 
(/usr/lib/autofs/lookup_ldap.so: undefined symbol: 
krb5_get_init_creds_keytab)


i could find SOME information about this being a problem with sasl and 
krb packages not linked against ldap, but i have no idea what to do from 
here? i think i even saw this a bug fixed in OLDER autofs version so im 
a little confused now....

regards,
*nail

From: Greg Bradner <gregb@rhythm.com>
Subject: auotfs v4
Date: Thu, 06 Nov 2003 10:11:47 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FAA8EE3.1060109@rhythm.com>
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

Any ideas what 'mount table full' means?
Nov  6 10:08:44 linn automount[27555]: >> NFSv3 not supported!
Nov  6 10:08:44 linn automount[27555]: >> mount table full
Nov  6 10:08:44 linn automount[27555]: mount(nfs): nfs: mount failure 
fs7:/vol/vol0/systems/celia/utils on /celia/utils/
Nov  6 10:09:15 linn automount[1899]: attempting to mount entry 
/misc/hsm_cache
Nov  6 10:09:15 linn automount[27589]: >> NFSv3 not supported!
Nov  6 10:09:15 linn automount[27589]: >> mount table full
Nov  6 10:09:15 linn automount[27589]: mount(nfs): nfs: mount failure 
fs8:/vol/vol0/hsm_cache on /misc/hsm_cache/

Everything works fine after a reboot.

-- 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com

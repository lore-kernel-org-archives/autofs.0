From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: New Debian packages
Date: Fri, 10 Jun 2005 01:03:10 +0200
Message-ID: <20050609230310.GA25635@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Ian (and all others interested),

I've uploaded 4.1.4-3 to Debian unstable, now that sarge has shipped. You
might be interested in the following patches for inclusion in upstream:

 - 064_support_options_on_nis_maps: Supports auto.master options on
   "+"-included NIS maps.
 - 065_fix_master_map_in_ldap: Bugfix for rc.autofs.in script with master
   map in LDAP.

Also, the Debian packages have switched to using ucf for the configuration
files; you might want to include that in your Debian packages.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

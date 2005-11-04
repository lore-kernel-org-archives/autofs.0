From: Vince Busam <vbusam@google.com>
Subject: LDAP entries cached forever [PATCH]
Date: Fri, 04 Nov 2005 15:25:43 -0800
Message-ID: <436BEDF7.6020607@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

An ldap mountpoint will be cached forever until autofs is restarted or gets a SIGHUP. 
Does it make sense to alter the behavior to automatically age out old entries and re-query 
the ldap server every once in a while?

Something like this (though without the hacky environment variable config):
http://www.sixpak.org/vince/autofs-age-ldap-cache.diff

Vince
